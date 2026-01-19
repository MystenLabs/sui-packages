module 0xba734e109ca5c6b1aa99900de47a5c713de2b681188a2defb943e98cbae0508b::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<WAL>(arg0, 6, b"WAL", b"WAL Token", b"WAL is the payment token for storage on the Walrus protocol, with the payment mechanism designed to keep storage costs stable in fiat", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRggEAABXRUJQVlA4IPwDAACQGACdASqAAIAAPm0ykkakIyGhLRuoaIANiUAaxbzME83vx/LU9V/AcnbQB/l+izzMf7Re5rngPaA9F3pbP8zgonT1rpv8B7GLfW8f/RP9JxgfLB0e8HH9N/Oj9Bv1GSgKm+wOR/2BvroMYJwwYdjxUAGEa4iQ6J7+eu7ofQcy5+DxtfqPBiKVvoL47Lv9iLOCAPmoke9DWb/zRFgX3Y7Fr8rjixnjBY3bu8DT/ROXUfjfnbqEFtW3r3jz8acbL57lX/BuryEldyLmciwAAP73a6kyiCpL/8oF5+efnVQNMDPIF6m5YsAAT+kG2inK/iKN6ZOVtaUT36U+qz9Da1E8IQXbK6SR5UrgMePlBPF96GhiIbvoHHM0B2z6QqPOaszoCmb/CF7l6RxMt3yFXiVSk3/jDF6gwyd/D6apwcQpKJIDKMEwvZQ9+8B7RzQ2Uq9LoNRSuGcPUqDBSyDti0fAeg5kPRqa2qwitq5ZQHKT5fF1bE+rd5RiQ+V8poPW5f7nn/8Cf9N2V7Znd8+gBW9XxYH9LVQnYVw5Hf9C7Bl8APc9Njn7Fz0z5quNLvajeViBZYBRlkIP08fh4IN9QEjsvYMYpeaSKG2jSA4E4dfqsajTqxG68j+B17y/PhxeHkfrwLBKbEAkX+B84q5lvOYVsKt7VowvDmUmdaQEe0l4hKU56S7F9ry1nl/lkgBxaCNqtyjXN/yQ2pAOWBkTeSvTbe+912NibJCLPX3h9qTEKEDAa+S72jHqfWBkoYvWwmtt+MHzCKv1ntxI48GPgNk/vEoJO6Aftj52jERKZKobbbVdl76H1zIDckbfNzAmUi8vfelxInrkC6cT3XTyxqP0p/O2KGbJJnm9564bVs0ia9TiCXi/8pGv1Byov0FMMlbt6uF/6zkMqzcRe/99L7GTy6zzDYDxIQ627HoE4QUGSTlLOAZ6BvuVfumRyoFH5Vx8acYnk4uxVRlxEjjmOWXwSx9A9/UPtgj8VvjvC/shZqs6QVq+rSUUr2gsw+2YFGS3GmIKXdtxhejmK/lJf8csLDBwQ68neeBBceWEwt0ZifWCyq8F/HH//P1JclBKFI3pjdOyp12zHm+D2WOJtdCGPXLrQG4cFj9H2Wd3RdX9xWt+ItPpUBC2ZODDe6JIxvJ7p+2dpWyn9wk1wxaqgswC5AYfYd7m0fxG2etYwJbFPsJaXR8w7O/SV781lJ106PjCWm2J1/8QTXbUcdg4Y0qsyklmo3A6aCzN6RABnEAvCwYHdOzwSGNYSjNjvqe4Hu3SuCAB52IQxTeXIukWsZvV2JOk4Z78jYgco/C60WyjA5yLmc6UV4ySvqdwSuJuyHRJ9xKLx+t8AAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

