module 0xe49c1f90986fd8e7b10f42c9bfc3c1c98fb047ded15d16e4d677a463173285ee::batman {
    struct BATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATMAN>(arg0, 6, b"Batman", b"A Super Hero", b"Wherever you know him from - movies, TV shows, video games or comics - Batman is proof you dont need superpowers to be a Super Hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/batman_641b775be4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

