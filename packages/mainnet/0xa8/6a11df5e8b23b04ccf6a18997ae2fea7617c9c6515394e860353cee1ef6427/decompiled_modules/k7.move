module 0xa86a11df5e8b23b04ccf6a18997ae2fea7617c9c6515394e860353cee1ef6427::k7 {
    struct K7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: K7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K7>(arg0, 9, b"K7", b"7K", b"Where memes turn into moonshots! Launch, trade, and laugh your way to the top!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6029360f1d328d6069e3d2634eeab40fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

