module 0xd35dbb9bafb7c6e608dc99e7ce5151a7dcf89f2bfc1f6a285428c39dea61a9ef::lastmeal {
    struct LASTMEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASTMEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASTMEAL>(arg0, 8, b"Lastmeal", b"Steak and lobster", b"LAST WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/56de5cf0-14a4-4f70-9b5b-c7d9807b2ac9.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LASTMEAL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASTMEAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASTMEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

