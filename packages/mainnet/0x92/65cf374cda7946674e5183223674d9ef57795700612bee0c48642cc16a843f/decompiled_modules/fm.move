module 0x9265cf374cda7946674e5183223674d9ef57795700612bee0c48642cc16a843f::fm {
    struct FM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FM>(arg0, 9, b"FM", b"FunnyMoney", x"0a0a2246756e6e794d6f6e69652028464d29202d204c6175676874657220746861742050617973220a0a2247657420726561647920746f204c4f4c20796f75722077617920746f207765616c7468212046756e6e794d6f6e69652069732074686520756c74696d617465206d656d652d62617365642063727970746f63757272656e6379207468617420726577617264732068756d6f7220616e6420637265617469766974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b8b56ea-81a6-442a-aea9-b958b5f831e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FM>>(v1);
    }

    // decompiled from Move bytecode v6
}

