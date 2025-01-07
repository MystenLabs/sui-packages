module 0x5fd325b1f6a4175cb4c4b9d74b079a3952316c30580a52ef14de7b050c570966::wink {
    struct WINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINK>(arg0, 6, b"Wink", b"Wink Sui Cat", b"Cat know the future it's winking at sui guys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000120831_2820fb4b36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

