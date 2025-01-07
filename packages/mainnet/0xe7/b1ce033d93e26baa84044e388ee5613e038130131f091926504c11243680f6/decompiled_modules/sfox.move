module 0xe7b1ce033d93e26baa84044e388ee5613e038130131f091926504c11243680f6::sfox {
    struct SFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOX>(arg0, 6, b"SFOX", b"Suitiee Fox", b"The girl was born in the largest economic and scientific and educational center of the Urals, the city of Yekaterinburg with a population of one and a half million. Since childhood, she was fond of drawing, becoming older she became interested in computer games. As a schoolgirl, the girl loved to watch animated films, comics, and play computer games. Even then, she became interested in cosplay. She liked to imagine herself as one of the heroines of this or that anime. After coming of age, the girl began to upload candid photos on her pages on the social network. Then erotic videos appeared, where the model acted as animated characters, most often they were elves and foxes. In just two years, the girl managed to attract the attention of a million audience and interest eminent directors with her professionalism. In her free time, Sweetie Fox loves to draw, especially since she was passionate about this activity since childhood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sfox_c71df10149.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

