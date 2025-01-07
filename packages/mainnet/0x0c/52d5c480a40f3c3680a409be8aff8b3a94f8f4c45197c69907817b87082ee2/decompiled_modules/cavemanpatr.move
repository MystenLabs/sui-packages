module 0xc52d5c480a40f3c3680a409be8aff8b3a94f8f4c45197c69907817b87082ee2::cavemanpatr {
    struct CAVEMANPATR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVEMANPATR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVEMANPATR>(arg0, 6, b"CAVEMANPATR", b"PATRIOT CAVEMAN", b"Patriot Caveman is the meme token smashing through the SUI blockchain with a stone club of freedom! Leading his tribe to financial independence!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_205747136_3e36c53cb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVEMANPATR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAVEMANPATR>>(v1);
    }

    // decompiled from Move bytecode v6
}

