module 0x464eb5daaf51e5cb484cb7fde1a51f5a574115908a10c0572eb064a5d29b391e::dbuy {
    struct DBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUY>(arg0, 6, b"DBUY", b"DON'T BUY", x"0a0a4974732070726f6261626c79206265737420696620796f752061766f6964207468697320746f6b656e2e20416674657220616c6c2c207768792067657420696e766f6c76656420696e20736f6d657468696e6720746861747320706f6973656420746f2074616b65206f6666207768656e20796f7520636f756c64206a757374207761697420616e64206d697373206f75743f0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VID_20241014_225314_844_f467d237d8.mp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

