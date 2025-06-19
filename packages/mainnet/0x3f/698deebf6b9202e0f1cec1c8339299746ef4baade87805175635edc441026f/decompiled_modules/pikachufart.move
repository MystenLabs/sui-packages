module 0x3f698deebf6b9202e0f1cec1c8339299746ef4baade87805175635edc441026f::pikachufart {
    struct PIKACHUFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKACHUFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHUFART>(arg0, 6, b"PIKACHUFART", b"Pikachu Fart Sui", b"Farting Pikachu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig3bphp5ue7wmxexn2h6cks2sg7ngkewdfj22e4rzn2o4rtinpsgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHUFART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKACHUFART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

