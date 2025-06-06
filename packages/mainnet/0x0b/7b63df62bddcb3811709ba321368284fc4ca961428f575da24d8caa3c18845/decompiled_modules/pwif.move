module 0xb7b63df62bddcb3811709ba321368284fc4ca961428f575da24d8caa3c18845::pwif {
    struct PWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWIF>(arg0, 6, b"PWIF", b"PikaWifMask", b"PikaWifMask is the new gem of the time.. to the moon..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifascjqojzwboizferoq3tb4t7g5mx3dj35cm2c6kzo3tixgh5e3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PWIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

