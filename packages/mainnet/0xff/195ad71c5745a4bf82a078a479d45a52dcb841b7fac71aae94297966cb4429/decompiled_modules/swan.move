module 0xff195ad71c5745a4bf82a078a479d45a52dcb841b7fac71aae94297966cb4429::swan {
    struct SWAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAN>(arg0, 6, b"SWAN", b"SuiSWAN", b"SUISWAN IS TO SAVE THE ENDING WILD ANIMALS. WE WILL USE A CERTAIN PART OF OUR PROFIT FOR THESE ANIMALS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199419_52a1d8acc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

