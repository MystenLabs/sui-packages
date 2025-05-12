module 0x44bb703671a7d28ba689a780c8fd5aeb1a2123db2d695e5e89d11f4374f70853::kepp_sui {
    struct KEPP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEPP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEPP_SUI>(arg0, 9, b"keppSUI", b"kepler Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAGCAYAAAAL+1RLAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAqSURBVBhXY3z+8d9/BjTABGMwMjJiCv7//x8ugaLy/3+ISSgqYQAuiAwArnMM4YfMRxoAAAAASUVORK5CYII=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEPP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEPP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

