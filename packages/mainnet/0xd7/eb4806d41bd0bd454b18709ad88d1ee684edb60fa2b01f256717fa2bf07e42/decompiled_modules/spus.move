module 0xd7eb4806d41bd0bd454b18709ad88d1ee684edb60fa2b01f256717fa2bf07e42::spus {
    struct SPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUS>(arg0, 9, b"SPUS", b"SPUS", b"SAFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://volo.fi/vSUI.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPUS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

