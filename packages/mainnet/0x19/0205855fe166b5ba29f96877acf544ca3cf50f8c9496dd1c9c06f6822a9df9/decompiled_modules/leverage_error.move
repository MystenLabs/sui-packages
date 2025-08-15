module 0x190205855fe166b5ba29f96877acf544ca3cf50f8c9496dd1c9c06f6822a9df9::leverage_error {
    public fun market_not_supported() : u64 {
        1000001
    }

    public fun obligation_already_has_position() : u64 {
        1000002
    }

    public fun obligation_no_position() : u64 {
        1000003
    }

    // decompiled from Move bytecode v6
}

