module 0xea45e6d9123c7c6b97be43fdba4d3920b8aec1a1ee9221cfaaf82d1f21429e91::suispace {
    struct SUISPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPACE>(arg0, 9, b"SuiSpace", b"Sui Project", b"Sui Space Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/12d6880208fcd8b01cca097205d09fc6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISPACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

