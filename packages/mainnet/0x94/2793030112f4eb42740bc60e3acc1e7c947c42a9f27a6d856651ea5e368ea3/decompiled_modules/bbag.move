module 0x942793030112f4eb42740bc60e3acc1e7c947c42a9f27a6d856651ea5e368ea3::bbag {
    struct BBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BBAG>(arg0, 6, b"BBAG", b"Bitbag", b"A bag of Bitcoin", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRvgCAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPiTLoV5RPQ/sVd3id1WUDggugIAAPARAJ0BKoAAgAA+bTSUSCQioiEmFVrAgA2JZwhwAZjmxavPpAS3tb+ypzk5xWWvLjXXmCPYQ5LKyans+bE5vNRQ21pmUxXQKK0AH7t9vinJUpUgB60wUr2VqDvNqw4huirFz/F63QOag+YKXha5/YuTWQHBA69hL7KXYIw8bj3swerU3mXtCtFnKHqLHspGnfHAF6rDI6oAAP7VyYNP/Ey+FhY8zDJp+vN6vESCJTfXkm27IzZGo85FW/uMj1AVlZ1O5jH2KKWNJ91Yz61Jl3Kp2venRNC9VRSra7fRHzJ+0dEp3uZBB8npy+OuFh31zn6yLRRpAf2BT5GryxJocVsj64hJfffWfH1WCmK4WU7OFxRAtHgClcCI3hKK6ZwKGmgYZqzP1SuSW9hlbBND0w6t2xd7oO0BJDvEEuVf8USHkTwfksD5ot1L1dipuPurrvIqPE48dUt3bLHK6SCfjWyAK4yuTuhuOjfJqrKhV+eeg60cNhbVmzOlWbPi6JzsnbsRlBbEbawoU5UHHxvTUAUjxrQRaI1gLjuX/qatRz5VzjCSJnl9OpWE4R4OLh2rkE0sbcnv4pICMTpclTR2tfxGD8xnBxH29m0xkeGJzjZbsUg1nRtTYbgju8gUYRUgDVRdbK8andimtquOi1cQT3O4wFst6p0B528z+++4n22K+YfRMoal7unGSHMR0JCwmJFfx8JuWokzBOFIUrnwUEDoZMgvU/n/U7z+/qRdViX6XuTBEefW0/s93eFutSLftxupsBQ7Slfth8PDzDjzfoq5BOTxkgy9kIPXOzbGY/EOPPMcO1gb0hzm9no2MdwSv1uDLf3kmKcHrQv5RzxNZJCPYFR9gUaiUis42nxEGJhcCkchzkC8GkFejU25SK7HjoomExE0IP5AeIBtGaVsS/9MESf+a4MwAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

