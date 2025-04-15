module 0x350fe646e696560923f775bbdab02624b1d02d276ba318b16ec057c43c925ab7::moonb {
    struct MOONB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONB>(arg0, 6, b"MOONB", b"MOON BAGS", b"Grab your bags and let's moon this! No jeets, if you have to sell for burger money, do it politely without killing this chart! Dont be a douche. Socials will come", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreie6pcq4lnokokwt2pvaa3rcesdk5bag572z2to4a2bwbxgbhuvvee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

