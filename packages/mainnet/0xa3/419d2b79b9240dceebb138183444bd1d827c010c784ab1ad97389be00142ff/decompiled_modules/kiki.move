module 0xa3419d2b79b9240dceebb138183444bd1d827c010c784ab1ad97389be00142ff::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 9, b"KIKI", b"KIKICat on SUI", b"$KIKI is the largest IP in Giphy those have been used 10.6 billion views. Unlike other memes $KIKI own 100% ownership of the IP (visit : https://giphy.com/kikitech and verify). It is backed by one of the largest meme projects in history as the first technology integration partner on Solana chain. It is dedicated to build a community of AI agent based on popular IPs and provide technology to other meme projects. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/507b046d40b0ccf29949122189a7ea5ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

