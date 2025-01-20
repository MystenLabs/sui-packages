module 0x41789d86ca444a8d40d3555d80808b904181dc9b816b7fba3c2403db84065fe7::jfk {
    struct JFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFK>(arg0, 6, b"JFK", b"Jhon F Kennedy", b"Official Jhon F Kennedy Meme is HERE! Its time to celebrate everything we stand for: WINNING! Join my very special Trump Community. GET YOUR $JFK NOW. Have Fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027538_d2b24ad300.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

