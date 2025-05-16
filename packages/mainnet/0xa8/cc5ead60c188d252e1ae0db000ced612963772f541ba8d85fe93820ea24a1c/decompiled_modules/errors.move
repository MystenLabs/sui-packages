module 0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::errors {
    public fun EExecuteTooEarly() : u64 {
        404
    }

    public fun EForbidden() : u64 {
        400
    }

    public fun EPriceInfoObjectMismatch() : u64 {
        401
    }

    public fun EPricesInvalid() : u64 {
        402
    }

    public fun ERequestExecuted() : u64 {
        403
    }

    public fun ERequestInfoMismatch() : u64 {
        405
    }

    // decompiled from Move bytecode v6
}

