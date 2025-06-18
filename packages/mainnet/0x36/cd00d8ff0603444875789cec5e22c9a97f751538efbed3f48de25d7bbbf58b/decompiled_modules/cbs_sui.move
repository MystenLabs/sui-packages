module 0x36cd00d8ff0603444875789cec5e22c9a97f751538efbed3f48de25d7bbbf58b::cbs_sui {
    struct CBS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBS_SUI>(arg0, 9, b"cbsSUI", b"1 Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRogCAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSB8AAAABHyAWTPxR+zKYRkQEDYJsmzHMH2dyJ3hE/ydAxv17AFZQOCBCAgAAsBAAnQEqgACAAD5tNpNHpCMhoSkY6DCADYlpABXo/9jmdPkP3g63n47cATwz+ccSGkpmW+MH6i9gvpSDdMOJ+OsaixK4n3B8RdSCWQ4mlg0e9A1OVGjk3NiI5tq8ISY6aEt3/VQXs1n0Il//PUn32E/1m+AfKFt+yguQv+/q9u6waAkhZin4P+FAos4QAAD++5zACuNNLPP+t5BRfKN7qc7dwm1aqshNHMiFQBaCsVVAVv58C+BRTzvJDWjSJsZ1GzDYRc0xSyleP264PIv9FJWWgJSXQN+eBs9Ac/k8WA/HsZqFTUaRe0mijpMVQ1hEXjsOfkJVJpIO63h+r9IPGQB4dNdWo4L08/0C0U+lXdO+hB7tu0h0oDzO7ph4IDhuDZSbvbZRZae9PpbnhMKZCxnmbMZVyNAig34i/Ynb5le5brhkxblMPX5NYVsTV78AJREb2bJYrNPid2LeHHOvU28Jn6uMTcT6klVjlE8SaDVO/4Ico4hdCy4tG8TsJGrU0W1bc4Myg5blHhdhkg90l7csrFYku3WsvDeB93Alwo/+CCdziBWErzS7aLqz2rl92vZ5ZMYl+kmaPXPaE1ouWKqOZT5O4ceiooujtgexb8gHRcFWhzvG6f2BtGQTa8FmjJqD+iUY0/jK4dGtC19q9FEbr/hO7258+eXMFfHu7BQbsypcHUKrwu03YLCLMYTzTW2KTkAEx4tWzUW7DfY+I4vy+T3M5VaLhuN++QBFU/zMFcTWjO9V4jLk/EIAAAAAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

