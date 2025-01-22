module 0xfb25cb4c3a393a1ce2729fcd88e1b4493848a088c53a35ca798ae0a0906df7b0::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 9, b"CAPY", b"CAPYSPLASH", x"4361726c6f74612c2074686520637572696f75732063617079626172612c20666f756e6420612063796c696e646572206c6162656c6564202244616e67657221204578706c6f736976652122205468696e6b696e67206974207761732061206769616e7420636f636f6e75742c2073686520686561646275747465642069742e0a0a424f4f4d210a0a4669736820666c65772c204361726c6f7461206c616e64656420696e20746865206d75642c20616e6420736169643a0ae28094204265737420636f636f6e7574206576657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1e8e450a3e01db19108a2186ed62b8c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

