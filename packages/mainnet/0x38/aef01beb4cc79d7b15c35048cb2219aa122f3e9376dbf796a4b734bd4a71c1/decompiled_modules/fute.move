module 0x38aef01beb4cc79d7b15c35048cb2219aa122f3e9376dbf796a4b734bd4a71c1::fute {
    struct FUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTE>(arg0, 6, b"FUTE", b"Fuck the Jeets", b"\"Fuck the Jeets\" is the perfect token for anyone looking to make a bold statement in the crypto world with a dash of humor. Created to express the shared frustration towards those who try to manipulate the market, this token is dedicated to everyone who's tired of seeing \"jeets\" (panic sellers) spoil the fun. It's a rebellious and sarcastic mix for those who want to stand with the community, no filter needed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056010_c214d43de9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

