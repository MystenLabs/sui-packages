module 0xd617c7e849f317ac2027b5190b11384f3651acbe7b542001c97fd82624e2b6b3::suger {
    struct SUGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGER>(arg0, 6, b"SUGER", b"Glucose", x"4c696665206e6565647320656e657267792c20796f757220706f7274666f6c696f206e65656473202453554741522e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735785530104.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

