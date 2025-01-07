module 0x6a6890c34b1e9bda1d5d36ac47a6df871edeef05c45d25ce7dc7bdedae9f1aef::ysdk {
    struct YSDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSDK>(arg0, 6, b"YSDK", b"Yusuf Dikec", b"Yusuf Dike (born 1 January 1973) is a Turkish sport shooter who competes in the pistol events. He is a retired non-commissioned officer of the Turkish Gendarmerie and a member of Jandarma Gc Sports Club.[1][2] He has been subject to overnight fame and various Internet memes due to his casual attire combined with minimal equipment during the 2024 Summer Olympics in which he won a silver medal in the 10 meter air pistol mixed team event alongside his teammate evval layda Tarhan.[3] Dike used the following expression in his life philosophy on the official Olympic page: Success doesn't come with your hands in your pockets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010039_e59740c663.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

