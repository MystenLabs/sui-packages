module 0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c {
    struct E4CTotalSupply has key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<E4C>,
    }

    struct E4C has drop {
        dummy_field: bool,
    }

    fun init(arg0: E4C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<E4C>(arg0, 9, b"E4C", b"$E4C", b"The $E4C token, serving as the universal currency within the E4C gaming ecosystem known as E4Cverse. It is designed to satisfy the development needs of the E4C gaming ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ambrus.s3.amazonaws.com/E4C-tokenicon.png")), arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E4C>>(v2);
        let v4 = E4CTotalSupply{
            id           : 0x2::object::new(arg1),
            total_supply : 0x2::coin::treasury_into_supply<E4C>(v3),
        };
        0x2::transfer::freeze_object<E4CTotalSupply>(v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<E4C>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<E4C>>(0x2::coin::mint<E4C>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

