module 0x85ed54f6b55054643b767deb7d896807353debd57ec2da31a051f55d2f97e92d::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"Memecoin", b"LETTUCE", b"lettuce man is the official token of the lettuce hands those people who sell in panic,but with style . tribute to all those who have fallen into selling before the hing...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/162ce3cea3c2cfd1907d181dbea5e651blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

