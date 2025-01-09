module 0x22cb3d477277f083fac27401c4f0a16ed2a5ea388ca3e32aef5f6ced05f25824::dasha {
    struct DASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASHA>(arg0, 6, b"DASHA", b"Dasha koreyka", x"48692c2049e280996d206461736861206b6f7265796b612c20616e642074686973206973206d79206f6666696369616c20746f6b656e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736437446115.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DASHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

