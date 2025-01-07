module 0x5a625c48c0a3d30b90b69abf619ba9fad65471442984166296722a6a4317c28::nao {
    struct NAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAO>(arg0, 6, b"NAO", b"Nong Nao", b"Hello Welcome to Nong Nao Community! Would you like to be my friend forever and take the journey with me?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_e26ce8e936.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

