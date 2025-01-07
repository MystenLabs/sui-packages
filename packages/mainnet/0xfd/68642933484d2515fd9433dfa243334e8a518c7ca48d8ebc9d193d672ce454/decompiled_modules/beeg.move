module 0xfd68642933484d2515fd9433dfa243334e8a518c7ca48d8ebc9d193d672ce454::beeg {
    struct BEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEG>(arg0, 6, b"BEEG", b"BeegBlueWhale On Sui", b"$BEEG is a unique and innovative community-driven token designed to foster engagement and participation within the cryptocurrency ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_091339_31166b4c30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

