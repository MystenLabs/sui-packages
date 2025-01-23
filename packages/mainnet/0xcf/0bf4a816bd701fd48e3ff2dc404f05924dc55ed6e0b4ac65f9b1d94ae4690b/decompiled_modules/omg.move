module 0xcf0bf4a816bd701fd48e3ff2dc404f05924dc55ed6e0b4ac65f9b1d94ae4690b::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG>(arg0, 6, b"OMG", b"OG Meme Generation", b"OG Meme Generation coin is a tribute to the timeless, hand-drawn memes created long before AI took over. These original memes have a spirit and emotion that machines cant replicateeach stroke carries human wit, humor, and creativity. AI lacks the soul and emotional depth that makes these classic memes so memorable. By supporting OMG , youre embracing the art that reflects genuine human experience, proving that technology cant replace the heart behind handmade creations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_061024_124_2bb6ba072d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

