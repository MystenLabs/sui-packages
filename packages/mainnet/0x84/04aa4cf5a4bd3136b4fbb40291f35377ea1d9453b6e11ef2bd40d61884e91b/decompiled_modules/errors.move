module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors {
    public fun EAddressTokenMismatch() : u64 {
        30
    }

    public fun ECollateralTooLow() : u64 {
        6
    }

    public fun EEmptyVaultList() : u64 {
        21
    }

    public fun EInterestRateOutsideRange() : u64 {
        7
    }

    public fun EMinDebtTooLow() : u64 {
        3
    }

    public fun ENoRedemptionHappened() : u64 {
        25
    }

    public fun ENoVaultsLiquidated() : u64 {
        14
    }

    public fun ENotUpgrade() : u64 {
        22
    }

    public fun EOnlyOneVaultLeft() : u64 {
        20
    }

    public fun EOperationFailed() : u64 {
        0
    }

    public fun EOracleIssue() : u64 {
        4
    }

    public fun EOracleTypeMismatch() : u64 {
        28
    }

    public fun EPriceFeedID() : u64 {
        1
    }

    public fun ERedemptionSlippageExceed() : u64 {
        19
    }

    public fun ERedemptionSlippageOutOfRange() : u64 {
        18
    }

    public fun ERepayShouldBeEqualDebt() : u64 {
        16
    }

    public fun ERequireOneDoriMinAmountToLeaveInSP() : u64 {
        29
    }

    public fun ERequireOneWeisMinAmountToLeaveInSP() : u64 {
        24
    }

    public fun EShutdownActive() : u64 {
        15
    }

    public fun EStabilityPoolIdMismatch() : u64 {
        26
    }

    public fun EStakerAlreadyExist() : u64 {
        10
    }

    public fun EStakerBalanceEmpty() : u64 {
        11
    }

    public fun EStakerBalanceNotEmpty() : u64 {
        12
    }

    public fun EStorkStateAddressMismatch() : u64 {
        27
    }

    public fun ETotalCollateralRatioCritic() : u64 {
        8
    }

    public fun EValueZero() : u64 {
        2
    }

    public fun EVaultIdAlreadyExistInRedemptionList() : u64 {
        9
    }

    public fun EVaultNotFoundInStore() : u64 {
        17
    }

    public fun EVaultRegistryIdMismatch() : u64 {
        13
    }

    public fun EWrongPackageVersion() : u64 {
        23
    }

    // decompiled from Move bytecode v6
}

