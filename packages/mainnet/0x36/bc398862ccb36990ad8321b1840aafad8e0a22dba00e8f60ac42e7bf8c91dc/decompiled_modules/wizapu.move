module 0x36bc398862ccb36990ad8321b1840aafad8e0a22dba00e8f60ac42e7bf8c91dc::wizapu {
    struct WIZAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZAPU>(arg0, 9, b"WIZAPU", b"Wizapu apu", x"57697a6170752077696c6c20636861726d206974732077617920696e746f20796f757220706f7274666f6c696f20616e6420796f757220686561727420f09f90a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2a27e824270367ffde90c4f326dfe0d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIZAPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZAPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

