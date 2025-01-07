module 0x977d5c460f782728c191368af66e0f7001591d85ecbe437c8239db5b4e576daf::trident {
    struct TRIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIDENT>(arg0, 6, b"TRIDENT", b"Sui Trident", b"The legendary Trident of Sui, forged in the deepest waters, now rises to claim its power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIDENTFIXED_1_7fba62db80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

