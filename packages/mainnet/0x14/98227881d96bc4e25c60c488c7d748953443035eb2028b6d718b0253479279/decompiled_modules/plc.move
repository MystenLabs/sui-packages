module 0x1498227881d96bc4e25c60c488c7d748953443035eb2028b6d718b0253479279::plc {
    struct PLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLC>(arg0, 9, b"PLC", b"PELACE", x"e38193e381aee382a4e383a9e382b9e38388e381afe38081e9bb84e889b2e38081e799bde38081e9bb92e381aee6af9be38292e68c81e381a4e78cabe3818ce38081e383a6e3838be383bce382afe381a7e68abde8b1a1e79a84e381aae4b896e7958ce381aee4b8ade381a7e9818ae38293e381a7e38184e3828be6a798e5ad90e38292e68f8fe38184e381a6e38184e381bee38199e38082e78cabe381afe6a5bde38197e38192e381abe4bcb8e381b3e38292e38197e38081e3819de381aee591a8e3828ae381abe381afe382abe383a9e38395e383abe381a7e5b9bee4bd95e5ada6e79a84e381aae6a8a1e6a798e381a8e6b8a6e5b7bbe3818fe38391e382bfe383bce383b3e3818ce5ba83e3818ce381a3e381a6e38184e381bee38199e38082e8838ce699afe381abe381afe38081e9aeaee38284e3818be381aae889b2e5bda9e381a8e69f94e38289e3818be381aae38388e383bce383b3e3818ce8aabfe5928ce38197e38081e8a696e8a69ae79a84e381abe38380e382a4e3838ae3839fe38383e382afe381a7e9ad85e58a9be79a84e381aae99bb0e59bb2e6b097e3818ce6bc82e381a3e381a6e38184e381bee38199e38082e381bee3828be381a7e99fb3e6a5bde38284e6849fe68385e3818ce7b5b5e794bbe381abe6bab6e38191e8bebce38293e381a7e38184e3828be3818be381aee38288e38186e381aae38081e4b88de6809de8adb0e381a7e5b9bbe683b3e79a84e381aae4b896e7958ce3818ce5ba83e3818ce381a3e381a6e38184e381bee38199e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a724613c-a190-497b-bfa8-a73c6f371368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

