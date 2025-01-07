module 0xc6eeb0168e47c359a1b7a63f3c7a3f614d1cca9b8a08e40d5413f79e5bb1a0f1::wit {
    struct WIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIT>(arg0, 6, b"WIT", b"What in Tarnation?", b"The \"What in tarnation\" meme is a humorous internet meme that plays on a stereotype of a Southern American expression of bewilderment or surprise. The meme format typically includes an image of an animal or person, often with a cowboy hat added digitally to emphasize the Southern aspect. The phrase \"What in tarnation?\" is an archaic and humorously exaggerated way of saying \"What in the world?\" or \"What on Earth?\" The comedic element is enhanced by the juxtaposition of the cowboy hat with subjects that are incongruous or absurd, creating a visual pun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tarnation_d3cf7e6fb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

