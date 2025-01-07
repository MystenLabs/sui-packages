module 0x4c6a9bd590b4d79bf2a8393bc8041b69163fb3e867e4feccbe8dad57d376edfd::aquaman {
    struct AQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMAN>(arg0, 6, b"AMEN", b"Aquaman", b"King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1752259479243243520/KgIKkuSV_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUAMAN>>(v1);
        0x2::coin::mint_and_transfer<AQUAMAN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun reounceownership(arg0: 0x2::coin::TreasuryCap<AQUAMAN>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

