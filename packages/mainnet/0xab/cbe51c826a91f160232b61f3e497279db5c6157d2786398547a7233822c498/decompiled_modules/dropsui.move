module 0xabcbe51c826a91f160232b61f3e497279db5c6157d2786398547a7233822c498::dropsui {
    struct DROPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPSUI>(arg0, 6, b"DropSui", b"Droplets Sui", b"Droplets Sui is the refreshing spirit of the crypto world, flowing through the blockchain like cool raindrops, bringing a splash of excitement to its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5647fhdg_f5e9f44537.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

