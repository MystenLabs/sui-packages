module 0x79a91094739629c7c4e37cb0319113d50ec77a54bec450be517b25e9f97125d6::deviloni {
    struct DEVILONI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEVILONI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEVILONI>>(0x2::coin::mint<DEVILONI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEVILONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVILONI>(arg0, 6, b"DEVILONI", b"The Devil Oni", b"In Japanese folklore, Oni are demons or ogres. They are typically large and scary-looking with red or blue skin, horns, and sharp claws. They are known for their strength and love to cause trouble. Sometimes, they are even said to eat people!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FG_Xnjgp_QWYAAR_1q_J_051d0e241b.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVILONI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEVILONI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVILONI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

