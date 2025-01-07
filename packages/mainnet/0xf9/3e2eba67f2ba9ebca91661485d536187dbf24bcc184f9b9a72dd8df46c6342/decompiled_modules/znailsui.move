module 0xf93e2eba67f2ba9ebca91661485d536187dbf24bcc184f9b9a72dd8df46c6342::znailsui {
    struct ZNAILSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZNAILSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZNAILSUI>(arg0, 6, b"ZNAILSUI", b"Pink Znail", b"The best snail and first on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241013_231756_b5bd8af002.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZNAILSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZNAILSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

