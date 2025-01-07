module 0x1b091ad5cd740a49ad25d57699265f52f47bc90fd5e7749cf0ec80514bae029f::hanbaothefinlessporpoise {
    struct HANBAOTHEFINLESSPORPOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAOTHEFINLESSPORPOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAOTHEFINLESSPORPOISE>(arg0, 6, b"Hanbaothefinlessporpoise", b"HANBAO", x"48616e62616f207468652066696e6c65737320706f72706f6973650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728922166497_356908be3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAOTHEFINLESSPORPOISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBAOTHEFINLESSPORPOISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

