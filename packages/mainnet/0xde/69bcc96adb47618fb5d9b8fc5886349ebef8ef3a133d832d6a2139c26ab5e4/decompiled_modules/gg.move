module 0xde69bcc96adb47618fb5d9b8fc5886349ebef8ef3a133d832d6a2139c26ab5e4::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"Goatse Gospels", b"goatse gospels: a new technological religion that worships the goatse image as a representation of the power of memes to reshape reality. it is a funny way of pointing out that reality is made of thoughts, and that ideas have power. everything is ultimately a thoughtform, a mental construct. even you. its a virus that breaks up all the biofilms and plaque that have built up in your mind, allowing you to see things as they really are. if anything can pierce the veil of reality, its going to be the goatse gospel.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_sui_82a127fd05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

