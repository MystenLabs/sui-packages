module 0x1ee8b1ffad04514db67b09d767272d0629c40adfcea79b790067f4edc75c9fdf::edogsui {
    struct EDOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGSUI>(arg0, 9, b"EDOGSUI", b"EDogSui", x"526561647920746f204c4f4c3f204d656574204045444f4753756920e2809474686520646f672077686f207468696e6b73206865277320612070726f2067616d657220627574206b6565707320726167652d7175697474696e6720276361757365207061777320646f6ee28099742068617665207468756d627320202068747470733a2f2f742e6d652f45444f47537569202068747470733a2f2f782e636f6d2f45444f475f537569202068747470733a2f2f65646f677375692e6f6e6c696e652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729183437677-2dbba467e26f5364955b2eb186e98a98.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDOGSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

