module 0x150a3765f43bee5e67f8faa04ad8802aab8fe8656d270198b55f825d4816cffe::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"WET", b"WET - A Liquid Meme moving Through SUI", b"$WET is a liquid Entity born from the stillness of the pond. A symbol. A ripple. A movement. Flowing through SUI-Silent, strange, Unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibh5552nkf45sokiolhh2hshecrteie6njglf7ttv73chpulvqu4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

