module 0xdf6862fb4e732b3c8c5753ec4dc187e21ebfdb04b44c790c5b69434af9a2d712::booking_trust {
    struct BookingTrustEvent has copy, drop {
        booking_reference: 0x1::string::String,
        event_type: 0x1::string::String,
        document_hash: 0x1::string::String,
        issuer: 0x1::string::String,
        notes_hash: 0x1::string::String,
    }

    public entry fun record_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = BookingTrustEvent{
            booking_reference : arg0,
            event_type        : arg1,
            document_hash     : arg2,
            issuer            : arg3,
            notes_hash        : arg4,
        };
        0x2::event::emit<BookingTrustEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

