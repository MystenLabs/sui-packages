module 0x4f91f8c122952512774a5bdba7546aae5dc2e22a8f496d33f1443aa5118a8d81::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 6, b"PENGSUI", b"Peng Sui", b"In the chilly realms of the Sui Network, Peng Sui waddles along, spreading joy with each tiny step and every flutter of his wings. With his adorable charm and icy determination, this little penguin is on a mission to bring warmth and smiles to the blockchain world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_19_55_41_474935cf52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

