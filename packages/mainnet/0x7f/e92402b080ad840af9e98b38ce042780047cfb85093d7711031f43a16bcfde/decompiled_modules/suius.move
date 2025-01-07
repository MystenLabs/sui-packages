module 0x7fe92402b080ad840af9e98b38ce042780047cfb85093d7711031f43a16bcfde::suius {
    struct SUIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUS>(arg0, 6, b"SUIUS", b"SUIUS Maximus", b"As the emperor of Kekistan, SUIUS Maximus wields his influence with a sense of humor and an iron fist, ensuring that his digital realm remains a bastion of free speech and meme culture. His leadership has inspired a loyal following among crypto traders and shitposters alike, who see in him the embodiment of their ideals: freedom from censorship, decentralized power structures, and the ultimate victory of memes over globalist tyranny.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kek_max_212e98ba87.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

