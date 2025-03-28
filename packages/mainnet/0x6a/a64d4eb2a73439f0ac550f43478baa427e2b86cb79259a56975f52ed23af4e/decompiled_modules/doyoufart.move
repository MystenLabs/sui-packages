module 0x6aa64d4eb2a73439f0ac550f43478baa427e2b86cb79259a56975f52ed23af4e::doyoufart {
    struct DOYOUFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOYOUFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOYOUFART>(arg0, 6, b"DOYOUFART", b"FART FISH", b"The number #1fish meme of all time deserves to be #1 meme in the sui waters ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3788_451a73f4e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOYOUFART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOYOUFART>>(v1);
    }

    // decompiled from Move bytecode v6
}

