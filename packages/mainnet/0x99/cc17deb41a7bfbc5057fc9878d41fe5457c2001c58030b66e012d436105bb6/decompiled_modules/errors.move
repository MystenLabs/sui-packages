module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors {
    struct Errors has drop {
        dummy_field: bool,
    }

    public fun EConversationAlreadyExists() : u64 {
        9
    }

    public fun EEmptyMessage() : u64 {
        6
    }

    public fun EInvalidConversation() : u64 {
        10
    }

    public fun EMessageTooLong() : u64 {
        7
    }

    public fun EMessageTooShort() : u64 {
        8
    }

    public fun ENotAdmin() : u64 {
        1
    }

    public fun EProfileExists() : u64 {
        3
    }

    public fun EProfileNotExists() : u64 {
        4
    }

    public fun EStreamAlreadyLinked() : u64 {
        11
    }

    public fun EUnauthorized() : u64 {
        2
    }

    public fun EXPubKeyInvalid() : u64 {
        5
    }

    // decompiled from Move bytecode v6
}

