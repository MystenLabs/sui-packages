module 0xfc5981b7231c0e8d4370e5dfa5bbc1164be8db660ccdd23bc9655fa06e8ee847::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"Shinsui", x"245348494e5355490a0a7468652073696e63657269747920616e64206f726967696e616c697479206f662073756920686f6c64657220746f206b656570206272696e67207468697320696e746f206120627269676874206675747572652c206a757374206c696b6520746865206e616d6520225348494e222077686963682077696c6c206272696e67206e6577206d657461", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998523893.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

