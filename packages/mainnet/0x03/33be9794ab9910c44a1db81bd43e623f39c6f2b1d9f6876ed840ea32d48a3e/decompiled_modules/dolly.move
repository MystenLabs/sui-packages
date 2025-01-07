module 0x333be9794ab9910c44a1db81bd43e623f39c6f2b1d9f6876ed840ea32d48a3e::dolly {
    struct DOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLY>(arg0, 6, b"Dolly", b"DollySui", b"just a viral lil doggo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_212349_284_38f94a908f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

