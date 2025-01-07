module 0x319d1fe9df24c882fe2b4beb13beeeecfeb2a52039b1a33d91d681472c870cc::gdcusd {
    struct GDCUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDCUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDCUSD>(arg0, 6, b"GDCUSD", b"Green Dildo Candle", b"Which will hold its value long term...? Green Dildo Candle or the USD?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GREENDILDOCANDLESUI_8aac462d3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDCUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDCUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

