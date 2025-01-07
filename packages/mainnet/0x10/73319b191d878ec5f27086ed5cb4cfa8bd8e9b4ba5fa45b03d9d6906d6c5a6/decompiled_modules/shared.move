module 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::shared {
    struct Escrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_key: 0x2::object::ID,
        escrowed: 0x1::option::Option<T0>,
    }

    struct Obj has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    public fun swap<T0: store + key, T1: store + key>(arg0: &mut Escrow<T0>, arg1: 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key, arg2: 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Locked<T1>, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(0x1::option::is_some<T0>(&arg0.escrowed), 2);
        assert!(arg0.recipient == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.exchange_key == 0x2::object::id<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key>(&arg1), 1);
        0x2::transfer::public_transfer<T1>(0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::unlock<T1>(arg2, arg1), arg0.sender);
        0x1::option::extract<T0>(&mut arg0.escrowed)
    }

    public fun create<T0: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id           : 0x2::object::new(arg3),
            sender       : 0x2::tx_context::sender(arg3),
            recipient    : arg2,
            exchange_key : arg1,
            escrowed     : 0x1::option::some<T0>(arg0),
        };
        0x2::transfer::public_share_object<Escrow<T0>>(v0);
    }

    public entry fun min_treesirop(arg0: &mut 0x2::coin::TreasuryCap<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::mint(arg0, arg1, arg2, arg3);
    }

    public entry fun min_treesirop_facet(arg0: &mut 0x2::coin::TreasuryCap<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::mint(arg0, arg1, arg2, arg3);
    }

    public fun return_to_sender<T0: store + key>(arg0: &mut Escrow<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        assert!(arg0.sender == 0x2::tx_context::sender(arg1), 0);
        assert!(0x1::option::is_some<T0>(&arg0.escrowed), 2);
        0x1::option::extract<T0>(&mut arg0.escrowed)
    }

    public entry fun stage_one(arg0: 0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::object::id<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>>(&arg0);
        let (v0, v1) = 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::lock<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>>(arg0, arg1);
        let v2 = v1;
        0x2::object::id<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key>(&v2);
        0x2::transfer::public_transfer<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Locked<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun stage_three(arg0: Escrow<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>>, arg1: 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key, arg2: 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Locked<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        0x2::transfer::public_share_object<Escrow<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>>>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>>(swap<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>, 0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop::TREESIROP>>(v0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun stage_two(arg0: 0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::object::id<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>>(&arg0);
        create<0x2::coin::Coin<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet::TREESIROP_FACET>>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

