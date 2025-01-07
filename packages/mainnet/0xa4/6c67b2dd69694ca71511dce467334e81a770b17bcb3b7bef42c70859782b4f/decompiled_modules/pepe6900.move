module 0xa46c67b2dd69694ca71511dce467334e81a770b17bcb3b7bef42c70859782b4f::pepe6900 {
    struct PEPE6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE6900>(arg0, 6, b"Pepe6900", b"Pepe6900meme", b"You entered a universe where investing in Pepe and PEPE6900 represents a new frontier, with dreams of financial independence riding on the unpredictable tides of cryptocurrency. A world where purchasing digital assets often means diving into the realms of volatile markets fraught with both exhilarating highs and gut-wrenching lows. Social security feels more like an echo of a bygone era, as the promise of stability fades into a mere whisper amidst the noise of every paycheck being eaten away by taxes and expenses.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_02_22_21_19bd7b1616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

