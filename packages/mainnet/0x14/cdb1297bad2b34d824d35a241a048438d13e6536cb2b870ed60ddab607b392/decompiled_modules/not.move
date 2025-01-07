module 0x14cdb1297bad2b34d824d35a241a048438d13e6536cb2b870ed60ddab607b392::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 6, b"NOT", b"Nothing on Sui", x"204e6f20776562736974650a204e6f20580a204e6f2062756c6c736869740a20596f7520706f7374207573206f6e205820616e642077652072616964", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029217_6a4ea6f6ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

