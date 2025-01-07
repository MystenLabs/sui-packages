module 0x54f219a49cbe36991756c56fb2a6d1815e1f811feecef70782650cd9c4596160::ins {
    struct INS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INS>(arg0, 9, b"INS", b"Insite", b"Meme,comunitas,memek,gambling ,gundul,gandal,pengocok,handal,penyepong,mehong,send,nafsu,batu,adi,butss,ultraman,eddy,momo,guguyu,yatno,yanti,izzi,ezi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5038fb3e-749c-422d-9ed9-3eb479e1433d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INS>>(v1);
    }

    // decompiled from Move bytecode v6
}

