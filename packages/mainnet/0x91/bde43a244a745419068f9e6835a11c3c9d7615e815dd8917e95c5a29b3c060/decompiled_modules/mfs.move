module 0x91bde43a244a745419068f9e6835a11c3c9d7615e815dd8917e95c5a29b3c060::mfs {
    struct MFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFS>(arg0, 6, b"MFS", b"Matt Furie on Sui", b"Fan token of Matt Furie is an artist and also illustrator. He is known for creating Pepe series that debuted in 2005.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5489_7db0236d81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

