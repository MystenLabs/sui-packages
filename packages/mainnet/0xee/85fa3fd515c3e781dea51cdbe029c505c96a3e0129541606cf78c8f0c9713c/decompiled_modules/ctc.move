module 0xee85fa3fd515c3e781dea51cdbe029c505c96a3e0129541606cf78c8f0c9713c::ctc {
    struct CTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTC>(arg0, 9, b"CTC", b"Catcoin", b"New cat coin to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/10c9505781b9f3e213e12611c9bb3f6eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

