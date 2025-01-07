module 0x9c7dbe1c20bec24046ce60115b45c255b0d7d6127c9ed1f6801999269bfcadca::safesui {
    struct SAFESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFESUI>(arg0, 9, b"SAFESUI", b"Safe Sui", b"https://telegra.ph/SAFESUI-10-06", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/Qma3ke3VsudZKZ57ifHtU6hRkQr5YDR83hx3Jwe3Rd8hLC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFESUI>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

